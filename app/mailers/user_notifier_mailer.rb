class UserNotifierMailer < ApplicationMailer
  default from: 'info@makeitrealblog.com'

  def welcome_user(user)
    @user = user
    @url = 'https://make-it-real-blog-sebas.herokuapp.com/posts'
    mail(to: @user.email, subject: 'Bienvenido al Blog De Make It Real')
  end

  def new_post_mail(user, post)
    @user = user
    @post = post

    mail(to: @user.email, subject: 'Un nuevo post ha sido creado en Make It Real Blog')
  end
end
