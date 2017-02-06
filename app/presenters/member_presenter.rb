class MemberPresenter < SimpleDelegator
  def self.from_collection(collection)
    collection.map{|m| new(m)}
  end

  def plot_list
    plot_numbers.join(", ")
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
