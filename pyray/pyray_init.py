import ray

if __name__== "__main__":
    ray.init(address='auto', redis_port='8888', redis_password='janashakthi')
