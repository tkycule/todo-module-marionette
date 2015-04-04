class App.User extends Backbone.Model

  url: "#{App.env.apiHost}/v1/users"

  validate: ->

    errors = {}

    if @get('email') == ''
      errors.email =  '入力してください'
    else if !@get('email').match(/^[A-Za-z0-9]+[\w-]+@[\w\.-]+\.\w{2,}$/)
      errors.email =  '無効なメールアドレスです'

    if @get('password') == ''
      errors.password = '入力してください'
    else if @get('password').length < 8
      errors.password = '8文字以上で入力してください'

    if @get('password_confirmation') == ''
      errors.password_confirmation = '入力してください'
    else if @get('password') != @get('password_confirmation')
      errors.password_confirmation = 'パスワードが一致しません'

    return errors if !_.isEmpty(errors)
