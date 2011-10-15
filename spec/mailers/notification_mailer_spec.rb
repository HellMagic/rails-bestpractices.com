require "spec_helper"

describe NotificationMailer do
  describe "notify_comment" do
    before :each do
      @post = Factory(:post, :title => 'email post')
      @comment = CommentDecorator.new(Factory(:comment, :commentable => @post, :body => 'comment body'))
      @user = Factory(:user, :email => 'flyerhzm@gmail.com')
      @email = NotificationMailer.notify_comment("flyerhzm@gmail.com", @comment)
    end

    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to("flyerhzm@gmail.com")
    end

    it "should have the correct subject" do
      @email.should have_subject(/Comment on Post email post/)
    end

    it "should contain the comment's body in the mail body" do
      @email.should have_body_text(/comment body/)
    end

    it "should contain a link to the post" do
      @email.should have_body_text(/#{post_url(@post).gsub(/\//, '&#47;')}/)
    end

    it "should contain unsubscribe text" do
      @email.should have_body_text(/If you don't want to receive email notification, please unsubscribe it/)
    end

    it "should contain an unusbscribe link" do
      @email.should have_body_text(/#{edit_user_registration_url.gsub(/\//, '&#47;')}/)
    end
  end

  describe "notify_answer" do
    before :each do
      @question = Factory(:question, :title => 'email question')
      @answer = Factory(:answer, :question => @question, :answer_body => AnswerBody.new(:body => 'answer body'))
      @user = Factory(:user, :email => 'flyerhzm@gmail.com')
      @email = NotificationMailer.notify_answer("flyerhzm@gmail.com", @answer)
    end

    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to("flyerhzm@gmail.com")
    end

    it "should have the correct subject" do
      @email.should have_subject(/Answer to email question/)
    end

    it "should contain the answer's body in the mail body" do
      @email.should have_body_text(/answer body/)
    end

    it "should contain a link to the question" do
      @email.should have_body_text(/#{question_url(@question).gsub(/\//, '&#47;')}/)
    end

    it "should contain unsubscribe text" do
      @email.should have_body_text(/If you don't want to receive email notification, please unsubscribe it/)
    end

    it "should contain an unusbscribe link" do
      @email.should have_body_text(/#{edit_user_registration_url.gsub(/\//, '&#47;')}/)
    end
  end

  describe "notify_admin" do
    before :each do
      @post = Factory(:post)
      @email = NotificationMailer.notify_admin(@post)
    end

    it "should be set be delivered to admin" do
      @email.should deliver_to("flyerhzm@gmail.com")
    end

    it "should have the correct subject" do
      @email.should have_subject(/post a best practice/)
    end

    it "should contain text in the mail body" do
      @email.should have_body_text(/post a best practice/)
    end
  end
end
