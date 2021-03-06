angular.module('loomioApp').directive 'previewButton', ->
  scope: {comment: '=?', proposal: '=?', discussion: '=?'}
  restrict: 'E'
  templateUrl: 'generated/components/preview_button/preview_button.html'
  replace: true
  controller: ($scope, $translate) ->

    selectors = ->
      if $scope.comment
        '.comment-form .preview-pane, .comment-form__textarea-wrapper, .comment-form__in-reply-to'
      else
        'md-dialog .preview-pane, .lmo-textarea-wrapper'

    $scope.toggle = ->
      angular.element(document.querySelectorAll(selectors())).toggleClass('hidden')
      $scope.previewing = !$scope.previewing
    $scope.$on 'commentFormInit', ->
      $scope.toggle() if $scope.previewing

    $scope.translations =
      preview: $translate.instant('loomio_content_preview.preview_button.preview')
      edit:    $translate.instant('common.action.edit')
