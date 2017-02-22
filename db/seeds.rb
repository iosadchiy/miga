Setting.create! price_electricity: 3.5,
  price_water: 33,
  cashier: 'Великодворский П.С.',
  next_transaction_number: 1

Due.create!([
  {kind: :membership, purpose: "2017", unit: :per_square_meter, price: 9.18},
  {kind: :membership, purpose: "2016", unit: :per_square_meter, price: 6},
  {kind: :target, purpose: "Земельный налог 2016", unit: :per_square_meter, price: 0.032}
])

if ENV['FAKEDATA'] == "1"
  vasya = Member.create!(
    fio: "Пупкин Василий Иванович",
    address: "г.Севастополь, пр.Ген.Острякова 12, кв 4",
    phone: "+79780001122",
    email: "vasya@pupkin.ru",
    status: :active
  )
  petya = Member.create!(
    fio: "Забулдыкин Петр Петрович",
    address: "г.Севастополь, ул Маринеско 1, кв 2",
    phone: "+79780002233",
    status: :active
  )
  kolya = Member.create!(
    fio: "Голохвадько Николай Евгеньевич",
    address: "г.Северодвинск, ул.Ленина 10, кв 3",
    phone: "+79780004455",
    status: :deleted
  )

  Plot.create!(
    member: vasya,
    number: "123",
    space: 410,
    registers_attributes: [
      {kind: :electricity, name: "Основной", number: "111111111", initial_display: "10000", seal: "123"},
      {kind: :water}
    ]
  )
  Plot.create!(
    member: vasya,
    number: "125",
    space: 400
  )
  Plot.create!(
    member: petya,
    number: "321",
    space: 420
  )

  Due.create! [
    {kind: :entrance, purpose: "Водовод", unit: :per_square_meter, price: 50},
    {kind: :entrance, purpose: "Электричество", unit: :per_plot, price: 10000},
    {kind: :entrance, purpose: "Прием в члены", unit: :per_member, price: 10000},
    {kind: :target, purpose: "Налог на землю 2017", unit: :per_square_meter, price: 50},
    {kind: :target, purpose: "Апгрейд подстанции", unit: :per_plot, price: 20000},
    {kind: :target, purpose: "Зимний водопровод", unit: :per_member, price: 30000},
    {kind: :membership, purpose: "Членские взносы 2017", unit: :per_plot, price: 2400},
    {kind: :membership, purpose: "Членские взносы 2016", unit: :per_square_meter, price: 9.5},
  ]
end
