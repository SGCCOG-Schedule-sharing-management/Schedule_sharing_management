//= require rails-ujs
//= require activestorage
// 〜〜〜〜 以下を追加 〜〜〜〜
//= require flatpickr
//= require flatpickr/l10n/ja
// 〜〜〜〜 以上を追加(require turbolinksより上に追加) 〜〜〜〜
//= require turbolinks
//= require_tree 

$(document).on('turbolinks:load', function () {
  $('#schedule_group_id').change(function () {
    var groupId = $(this).val();

    $.ajax({
      url: '/groups/get_group_info',
      type: 'GET',
      data: { group_id: groupId },
      dataType: 'json',
      success: function (data) {
        $('#schedule_content').val(data.content);
        // 予定日や場所なども同様に取得して表示させる

        // 例えば、予定日が date フィールドの場合
        $('#schedule_start_time_1i').val(data.actual_date.split('-')[0]);
        $('#schedule_start_time_2i').val(data.actual_date.split('-')[1]);
        $('#schedule_start_time_3i').val(data.actual_date.split('-')[2]);

        $('#schedule_location').val(data.production_location);
      }
    });
  });
});