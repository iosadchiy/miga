if ENV['FAKEDATA'] == "1"
  vasya = Member.create!(
    fio: "Пупкин Василий Иванович",
    address: "г.Севастополь, пр.Ген.Острякова 12, кв 4",
    phone: "+79780001122",
    status: Member::ACTIVE
  )
  petya = Member.create!(
    fio: "Забулдыкин Петр Петрович",
    address: "г.Севастополь, ул Маринеско 1, кв 2",
    phone: "+79780002233",
    status: Member::ACTIVE
  )
  kolya = Member.create!(
    fio: "Голохвадько Николай Евгеньевич",
    address: "г.Северодвинск, ул.Ленина 10, кв 3",
    phone: "+79780004455",
    status: Member::DELETED
  )

  Plot.create!(
    member: vasya,
    number: "123",
    space: 410
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
end
