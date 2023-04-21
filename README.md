# vakinha_burger

App de delivery de comida fictício, desenvolvido na [Academia do Flutter](https://academiadoflutter.com.br/).

![logo](./assets/images/logo_rounded.png)

## Executando o projeto

O projeto consiste em um App android/ios e um backend local.

### App
Certifique-se de ter o [flutter](https://docs.flutter.dev/) instalado corretamente. Recomendo o [FVM](https://fvm.app/) para utilizar a mesma versão que foi utilizada durante o desenvolvimento.

Vá até o diretório do projeto e execute:

```sh
fvm use
flutter pub get
```

Gere o arquivo `.env` utilizando o `.env.example` como template:

```sh
cp .env.example .env
```

e então preencha as variáveis de ambiente no arquivo gerado.

Certifique-se de ter um emulador ou dispositivo físico devidamente configurado, e então execute:

```sh
flutter run
```

ou utilize o modo debug da sua IDE preferida, recomendo o vscode.

### Backend

Instale globalmente o package `json_rest_server`:

```sh
dart pub global activate json_rest_server
```

Vá até o diretório `backend`.

Se estiver rodando o app em um dispositivo físico, abra o arquivo `config.yaml` e preencha o parâmetro `host` com seu endereço IPv4 ou IPV6. OBS: garanta que o dispositivo e o computador estejam na mesma rede wifi.

Execute:

```sh
json-rest-server run # ou jrs run se preferir
```

#### Requests

Pode ser interessante testar as requests, como a criação de um usuário, por exemplo. Existe uma pasta `postman` com arquivos prontos para importação no [Postman](https://www.postman.com/). 

Outra opção é o [plugin REST Client para vscode](https://marketplace.visualstudio.com/items?itemName=humao.rest-client), na pasta http há arquivos com extensão `.http` devidamente preparados, mas antes de utilizar certifique-se de criar um `.env` e preencher a variável de ambiente `HOST`. Para realizar requests autenticadas realize login e preencha a variável de ambiente `ACCESS_TOKEN`.
