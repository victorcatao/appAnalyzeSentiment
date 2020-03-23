# Analyze Sentiment
MVVM + Rx + Quick/Nimble + Alamofire
Algumas considerações abaixo.
Prevenção de "no meu computador rodava": https://youtu.be/s_Cn-6PRkpc

## AccessToken
Segundo a documentação, o token da API do Twitter não expira. Pra não ficar fazendo a request de autenticação toda hora que abre o app, eu faço a request uma vez e salvo esse token no UserDefaults. Se o UserDefaults for apagado por algum motivo, a request é feita novamente.

## Autocomplete
Eu simulei uma busca pelo o que o usuário está digitando. Na verdade isso deveria ser feito com o endpoint "users/search", mas eu não tenho acesso porque estou na categoria mais básica (Standard) de acesso à API.
Pra resolver esse problema e simular essa requisição, eu faço uma request (fetchUsers) nos seguidores de alguma pessoa famosa (@zecapagodinho), no caso. Então, eu uso o que retorna dos seguidores dele para filtrar e exibir o autocomplete. Essa request tem um número de resultados limitado também.
Usei o debounce() e distinctUntilChanged() pra evitar requests desnecessárias.

## Darkmode
O app está preparado para o Darkmode :)
