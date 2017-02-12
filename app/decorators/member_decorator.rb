class MemberDecorator < Draper::Decorator
  delegate_all

  def plot_list
    h.safe_join plots.map{|plot|
      h.link_to plot, [:edit, plot]
    }, ", "
  end

  def space
    [
      object.space.to_s,
      I18n.t('shared.square_meters'),
      ("= " + plots.pluck(:space).join(" + ") unless plots.size <= 1)
    ].compact.join(" ")
  end

  def to_s
    [
      fio,
      ("(#{I18n.t('members.status.deleted')})" unless active?)
    ].compact.join(" ")
  end


  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
