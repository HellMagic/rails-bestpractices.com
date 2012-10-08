# == Schema Information
#
# Table name: notification_settings
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  value      :boolean(1)      default(TRUE)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class NotificationSetting < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection

  attr_accessor :description

  belongs_to :user

  ITEMS = ActiveSupport::OrderedHash[
    :global_email            , 'Receive email notification (global setting)' ,
    :comment_post            , 'Comment on my Rails Best Practice'           ,
    :after_post_comment      , 'Comment on Rails Best Practice after me'     ,
    :comment_question        , 'Comment on my Question'                      ,
    :after_question_comment  , 'Comment on Question after me'                ,
    :comment_answer          , 'Comment on my Answer'                        ,
    :after_answer_comment    , 'Comment on Answer after me'                  ,
    :answer_question         , 'Answer on my Question'                       ,
    :after_question_answer   , 'Answer on Question after me'                 ,
    :after_blog_post_comment , 'Comment on Team Blog after me'               ,
  ]

  def description
    ITEMS[self.name.to_sym]
  end
end

