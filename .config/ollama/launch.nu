$env.OLLAMA_KEEP_ALIVE = "30m"
$env.OLLAMA_MAX_LOADED_MODELS = 2
$env.OLLAMA_FLASH_ATTENTION = 1
$env.OLLAMA_KV_CACHE_TYPE = "q8_0"
$env.OLLAMA_MULTIUSER_CACHE = 1
$env.OLLAMA_NUM_PARALLEL = 4
$env.OLLAMA_NUM_THREADS = 4

# Restart Ollama
# killall ollama 2>/dev/null
ollama serve
