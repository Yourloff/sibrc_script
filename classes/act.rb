class Act
  def initialize; end

  def build
    {
      'title': 'Акт',
      "city": 'Красноярск',
      "date": Time.now.strftime('%d.%m.%y'),
      "basis_for_technical_expertise": 'Договор'
    }
  end
end
