# README

## Dependencies

- Docker
- docker-compose
- dnsmasq

#### Installing docker and docker-compose
To install docker just run ```curl -sSL https://get.docker.com/ | sh```
To install docker-compose just run ```sudo pip install docker-compose```

#### Installing dnsmasq
For install dnsmasq just run ```sudo apt-get install dnsmasq``` or the
appropriate command for your platform package manger

#### Configuring dnsmasq
Just create a file called /etc/dnsmasq.d/docker_dns.conf with the following
content
```
address=/dev/127.0.0.1
```

After installing dnsmasq run the docker dns container. This will start a nginx
reverse proxy in your machine, this proxy is generic so it's not included in the
project, it's recommended to save this command to a file and start automatically
with your machine
```
docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock -t jwilder/nginx-proxy
```

#### Running
To run the application just issue a ```docker-compose up -d```, this will start
the application, after the process is finished the application should be
accessible through [web.probebe.dev](http://web.probebe.dev)

** If it is not accessible run ```docker-compose ps```.
If the web contaner is exit run ```docker-compose run web bash``` and ``` bundle install --path=vendor/bundle```

#### Testing
To run the tests run a ```docker-compose run web bash```, this will start a
shell into the application context in which you'll be able to run a bin/rspec to
run all the specs
