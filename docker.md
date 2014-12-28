# Docker Commands

docker run -d -p 80:2368 -v /root/ghost-data-shehacks:/ghost-override dockerfile/ghost

docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock jwilder/nginx-proxy

docker run --name geekgirl-ghost -d -p 84:2368 -e "VIRTUAL_HOST=geekgirl.io,www.geekgirl.io" -v /root/ghost-data-geekgirl/:/ghost-override dockerfile/ghost

docker run --name girlgeeksydney-ghost -d -p 83:2368 -e "VIRTUAL_HOST=girlgeeksydney.com,www.girlgeeksydney.com" -v /root/ghost-data-girlgeeksydney/:/ghost-override dockerfile/ghost

docker run --name shehacks-ghost -d -p 85:2368 -e "VIRTUAL_HOST=shehacks.io,www.shehacks.io" -v /root/ghost-data-shehacks/:/ghost-override dockerfile/ghost

