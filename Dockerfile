# Empezamos desde la imagen base de Odoo
FROM odoo:17.0

# Copiamos los archivos de requerimientos a una carpeta temporal
COPY ./addons/l10n-ecuador/requirements.txt /tmp/ecuador-requirements.txt
COPY ./addons/vertical-hotel/requirements.txt /tmp/hotel-requirements.txt

# Instalamos las dependencias de Python (esto lo corre como usuario 'odoo')
RUN pip install -r /tmp/ecuador-requirements.txt
RUN pip install -r /tmp/hotel-requirements.txt

# --- CAMBIOS AQUÍ ---

# (Opcional pero recomendado) Instalar librerías del sistema
# CAMBIO: Cambiamos a 'root' para poder instalar
USER root
RUN apt-get update && apt-get install -y \
    libxml2-dev libxslt1-dev \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*
# CAMBIO: Volvemos al usuario 'odoo' para que el contenedor corra de forma segura
USER odoo

# --- FIN DE LOS CAMBIOS ---