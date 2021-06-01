FROM python:3.6

RUN apt-get update && \
    apt-get install tesseract-ocr -y && \
    apt-get clean && \
    apt-get autoremove

WORKDIR /home/app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY app app
COPY app.py boot.sh ./

RUN chmod a+x boot.sh

ENV FLASK_APP app.py

EXPOSE 5000

# Uncomment when not running on Heroku
ENTRYPOINT ["./boot.sh"]

# Comment if not running on Heroku
CMD gunicorn --bind 0.0.0.0:$PORT app:app
