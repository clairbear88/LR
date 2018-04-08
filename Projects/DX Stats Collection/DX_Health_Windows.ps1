.\curl localhost:9200/_cluster/health?pretty >health.txt
.\curl localhost:9200/_cat/indices?v > indices.txt
.\curl localhost:9200/_cat/shards?v >shards.txt
.\curl localhost:9200/_nodes/stats?pretty >stats.txt
.\curl localhost:9200/_nodes/hot_threads?pretty > threads.txt
.\curl localhost:9200/_cat/thread_pool?v >thread_pool.txt
.\curl localhost:9200/_nodes/_local/process?pretty > process.txt