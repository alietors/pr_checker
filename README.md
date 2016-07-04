# pr_checker
Simple Ruby program that gently remind to the owner and reviewer when a PR hasn't shown any activity for a while
# Config
You should have a config.yml file on config/ directory with the following parameters
```
REPO_OWNER: 'owner'
REPO_NAME: 'name'
OAUTH_TOKEN: 'oauth_token'
DAY_LIMIT_NUMBER: 2
IMAGE_URL: 'http://assets.sbnation.com/assets/2654061/chimp-smell.gif'
```

# Run unit tests
rake test
