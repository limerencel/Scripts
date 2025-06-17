## docker
A convenient way to install Docker, loading the script from [get.docker](https://get.docker.com/), for example: <br/>
`curl -sSL https://get.docker.com/ | bash`

## Common commands
check storage usage: `du -sh /path/to/directory/* | sort -hr`
## sysbench benchmark
`sysbench cpu --cpu-max-prime=20000 run`
`sysbench memory --memory-block-size=1M --memory-total-size=10G run`
*Disk*:
`sysbench fileio --file-total-size=1G prepare` && `sysbench fileio --file-total-size=1G --file-test-mode=rndrw --time=60 --max-requests=0 run`
clean up: `sysbench fileio cleanup`
