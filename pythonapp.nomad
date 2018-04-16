# docker driver.
job "pythonapp" {
  datacenters = ["[[.datacenter]]"]
  region      = "[[.region]]"
  type        = "batch"
  
  
  
  update {
    stagger      = "30s"
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "10m"	
	  auto_revert      = true
  }

  group "pythonapp" {
    count = 1

    task "pythonapp" {

      driver = "docker"

      config {
        #network_mode = "host"
        image = "127.0.0.1:5000/pythonapp:latest"
      }
      
      service {
        name = "pythonapp"
        tags = ["python", "app"]

        port = "http"
        address_mode = "host"

        check {
          type     = "http"
          address_mode = "host"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }

      resources {
        cpu    = [[.cpu]]
        memory = [[.memory]]

        network {
          mbits = [[.mbits]]
          port  "http"{
	  	static = 5123
          }
        }
      }
    }
  }
}
