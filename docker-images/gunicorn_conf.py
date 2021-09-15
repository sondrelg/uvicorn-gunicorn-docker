import json
import multiprocessing
import os

host = os.getenv('HOST', '0.0.0.0')
port = os.getenv('PORT', '80')
bind_env = os.getenv('BIND', None)

use_max_workers = int(i) if (i := os.getenv('MAX_WORKERS')) else None
workers_per_core = float(os.getenv('WORKERS_PER_CORE', '1'))
default_web_concurrency = workers_per_core * multiprocessing.cpu_count()

if web_concurrency := int(os.getenv('WEB_CONCURRENCY', None)):
    assert web_concurrency > 0
else:
    web_concurrency = max(int(default_web_concurrency), 2)

if use_max_workers:
    web_concurrency = min(web_concurrency, use_max_workers)

log_data = {
    'loglevel': os.getenv('LOG_LEVEL', 'info'),
    'workers': web_concurrency,
    'bind': bind_env or f'{host}:{port}',
    'graceful_timeout': int(os.getenv('GRACEFUL_TIMEOUT', '120')),
    'timeout': int(os.getenv('TIMEOUT', '120')),
    'keepalive': int(os.getenv('KEEP_ALIVE', '5')),
    'errorlog': os.getenv('ERROR_LOG', None),
    'accesslog': os.getenv('ACCESS_LOG', None),
    # Additional, non-gunicorn variables
    'workers_per_core': workers_per_core,
    'use_max_workers': use_max_workers,
    'host': host,
    'port': port,
}
print(json.dumps(log_data))
