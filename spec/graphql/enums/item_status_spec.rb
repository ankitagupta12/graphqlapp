describe Enums::ItemStatus do
  context 'have correct fields' do
    Given(:expected_enums) do
      {
        'ordered' => 'ordered',
        'preparing' => 'preparing',
        'ready_for_collection' => 'ready_for_collection',
        'delivered' => 'delivered'
      }
    end
    Then { Hash[subject.values.map { |key, value| [key, value.value] }] == expected_enums }
  end
end
