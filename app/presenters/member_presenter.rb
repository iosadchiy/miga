class MemberPresenter < SimpleDelegator
  def self.from_collection(collection)
    collection.map{|m| new(m)}
  end

  def self.active_plus_owner_of(plot)
    res = from_collection(Member.active)
    res << new(plot.member) if plot && !plot.member.active?
    res
  end

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

  def to_s
    [
      fio,
      ("(#{I18n.t('members.status.deleted')})" unless active?)
    ].compact.join(" ")
  end
end
