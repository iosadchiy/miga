class UtilityTransaction < Transaction
  belongs_to :register
  validates :start_display, :end_display, :difference,
    presence: true, numericality: {only_integer: true, allow_nil: true}
end
