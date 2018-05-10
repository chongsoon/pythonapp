FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

#COPy ./cert/* /usr/src/app/cert/

#RUN update-ca-certificates

#CMD ["/bin/sh"]

CMD ["python", "./main.py"]
