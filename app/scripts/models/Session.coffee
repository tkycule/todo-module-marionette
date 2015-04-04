class App.Session extends Backbone.Model

  url: "#{App.env.apiHost}/v1/sessions"

  validate: ->
    if @get('email') == ''
      return 'メールアドレスを入力してください'
    else if @get('password').length < 8
      return 'パスワードはを8文字以上で入力してください'

  parse: (data) ->
    @setUser(new App.User(data))
    return null

  currentUser: ->
    if localStorage.user
      @user ||= new App.User(JSON.parse(localStorage.user))
    else
      return null

  logout: ->
    localStorage.removeItem('user')
    @user = null
    @trigger('change')

  setUser: (user) ->
    localStorage.user = JSON.stringify(user.toJSON())
    @user = user
    @trigger('change')
