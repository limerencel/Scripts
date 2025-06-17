## docker
A convenient way to install Docker, loading the script from [get.docker](https://get.docker.com/), for example: <br/>
`curl -sSL https://get.docker.com/ | bash`

## Common commands
check storage usage: `du -sh /path/to/directory/* | sort -hr`  
running in background: `your_command > /dev/null 2>&1 &`
## sysbench benchmark
| type       | command                                           |
| ---------- | ---------------------------------------------- |
| CPU        | `sysbench cpu --cpu-max-prime=20000 run`       |
| RAM         | `sysbench memory --memory-total-size=10G run`  |
| prepare files | `sysbench fileio --file-total-size=1G --file-test-mode=rndrw prepare` |
| IO bench       | `sysbench fileio --file-total-size=1G --file-test-mode=rndrw run`   |
| clean up      | `sysbench fileio cleanup`                      |

