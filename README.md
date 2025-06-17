## docker
A convenient way to install Docker, loading the script from [get.docker](https://get.docker.com/), for example: <br/>
`curl -sSL https://get.docker.com/ | bash`

## Common commands
check storage usage: `du -sh /path/to/directory/* | sort -hr`
## sysbench benchmark
| type       | command                                           |
| ---------- | ---------------------------------------------- |
| CPU        | `sysbench cpu --cpu-max-prime=20000 run`       |
| RAM         | `sysbench memory --memory-total-size=10G run`  |
| prepare files | `sysbench fileio --file-total-size=1G prepare` |
| disk bench       | `sysbench fileio --file-test-mode=rndrw run`   |
| clean up      | `sysbench fileio cleanup`                      |

