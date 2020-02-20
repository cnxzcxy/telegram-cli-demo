# telegram-cli-demo

```
docker run -d -i -p 3345:3345 -v /Users/terry/.telegram-cli:/root/.telegram-cli --name="telegram-cli" cnxzcxy/telegram-cli telegram-cli --json -P 3345
```


```
//调试，获取json格式信息
docker run --rm -i -t -p 3345:3345 -v /Users/terry/.telegram-cli:/root/.telegram-cli cnxzcxy/telegram-cli telegram-cli --json -P 3345
```
