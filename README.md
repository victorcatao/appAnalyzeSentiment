# Analyze Sentiment
MVVM + RxSwift + RxCocoa + Alamofire + Quick/Nimble.

Prevenção de "no meu computador rodava": https://youtu.be/s_Cn-6PRkpc

Algumas considerações abaixo.


## AccessToken
Segundo a documentação, o token da API do Twitter não expira. Pra não ficar fazendo a request de autenticação toda hora que abre o app, eu faço a request uma vez e salvo esse token no UserDefaults. Se o UserDefaults for apagado por algum motivo, a request é feita novamente.

## API Analyze Sentiment
Ao ler a documentação do endpoint, vi que não era possível enviar várias sentenças em uma só request, apenas um texto. Porém, ao fazer alguns testes, verifiquei que a API (quase) sempre identificava quebras de linha como uma nova sentença e na response vinha o score separado por cada sentença. Por isso, decidi então juntar todos os tweets da usuário pesquisado em 1 sentença, separando-os por quebras de linha (\n). Dessa forma eu fiz apenas 1 requisição de Analyze Sentiment por usuário pesquisado, ao invés de n requisições.

## Autocomplete
Eu simulei uma busca pelo o que o usuário está digitando. Na verdade isso deveria ser feito com o endpoint "users/search", mas eu não tenho acesso porque estou na categoria mais básica (Standard) de acesso à API.
Pra resolver esse problema e simular essa requisição, eu faço uma request (fetchUsers) nos seguidores de alguma pessoa famosa (@zecapagodinho), no caso. Então, eu uso o que retorna dos seguidores dele para filtrar e exibir o autocomplete. Essa request tem um número de resultados limitado também.
Usei o debounce() e distinctUntilChanged() pra evitar requests desnecessárias.

## Darkmode
O app está preparado para o Darkmode :)
