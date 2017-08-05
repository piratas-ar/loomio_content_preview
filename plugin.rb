module Plugins
  module LoomioContentPreview
    class Plugin < Plugins::Base
      setup! :loomio_content_preview do |plugin|
        plugin.enabled = true

        plugin.use_component :preview_button, outlet: [
          :before_comment_form_textarea,
          :before_proposal_form_textarea,
          :before_discussion_form_textarea
        ]
        plugin.use_component :preview_pane, outlet: [
          :after_comment_form_textarea,
          :after_proposal_form_textarea,
          :after_discussion_form_textarea
        ]

        plugin.use_translations 'config/locales', :loomio_content_preview

        plugin.use_test_route(:setup_comment_preview) do
          sign_in patrick
          create_discussion.group.update(enable_experiments: true)
          @comment = CommentService.create(
            comment: FactoryGirl.build(:comment, discussion: create_discussion),
            actor: patrick
          )
          redirect_to discussion_path(@comment.discussion)
        end
      end
    end
  end
end
