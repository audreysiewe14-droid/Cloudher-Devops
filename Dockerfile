#Stage 1 : Builder (Semaine 5 - Multistage)
FROM python:3.11-slim

WORKDIR /app

#Proceder a la copie et a l'installation des dependances
COPY requirements.txt .
RUN pip install --no-cache-dir --default-timeout=100 --retries 5 -r requirements.txt

#Copie de l'application
COPY monapp.py .

#Creation d'un user non root
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 8501
#Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \ 
CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8501/_stcore/health')" || exit 1
CMD ["streamlit","run","monapp.py","--server.port=8501","--server.address=0.0.0.0"]
