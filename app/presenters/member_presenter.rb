class MemberPresenter < SimpleDelegator
  def plot_list
    plots.pluck(:number).join(", ")
  end

  def space
    [
      plots.pluck(:space).sum.to_s,
      I18n.t('shared.square_meters'),
      ("= " + plots.pluck(:space).join(" + ") unless plots.size <= 1)
    ].join(" ")
  end
end
