if ENV['FAKEDATA'] == "1"
  vasya = Member.create!(
    fio: "Пупкин Василий Иванович",
    address: "г.Севастополь, пр.Ген.Острякова 12, кв 4",
    phone: "+79780001122",
    status: Member::ACTIVE
  )

  Plot.create!(
    number: "123",
    member: vasya
  )
end
