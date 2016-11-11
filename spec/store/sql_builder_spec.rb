describe 'SQLBuilder' do

  it 'can select all' do
    builder = DriveConnect::Store::SQLBuilder.new('drives').select('*')
    expect(builder.to_sql).to eq [ 'SELECT "drives".* FROM "drives"', [] ]
  end

  it 'can select from a different table' do
    builder = DriveConnect::Store::SQLBuilder.new('directors').select('*')
    expect(builder.to_sql).to eq [ 'SELECT "directors".* FROM "directors"', [] ]
  end

  it 'can apply where clauseses' do
    builder = DriveConnect::Store::SQLBuilder.new('drives').select('*').where([:director_id, '=', 1])
    expect(builder.to_sql).to eq [ 'SELECT "drives".* FROM "drives" WHERE "drives"."director_id" = ?', [1] ]
  end

  it 'can insert in to the table' do
    builder = DriveConnect::Store::SQLBuilder.new('drives').insert(director_id: 1)
    expect(builder.to_sql).to eq [ 'INSERT INTO "drives" ("director_id") VALUES (?)', [1]]
  end

  it 'can update a record' do
    builder = DriveConnect::Store::SQLBuilder.new('drives').update([:id, '=', 1], { director_id: 15, foo: 'bar' })
    expect(builder.to_sql).to eq [ 'UPDATE "drives" SET "director_id" = ?, "foo" = ? WHERE "drives"."id" = ?', [15, 'bar', 1] ]
  end
end
