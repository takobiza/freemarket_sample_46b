class Size < ActiveHash::Base
  self.data = [
    {id: 0, name: 'XXS以下'},{id: 1, name: 'XS(SS)'},{id: 2, name: 'S'},{id: 3, name: 'M'},{id: 4, name: 'L'},{id: 5, name: 'XL(LL)'}
    ,{id: 6, name: '2XL(3L)'},{id: 7, name: '3XL(4L)'},{id: 8, name: '4XL(5L)以上'},{id: 9, name: 'FREESIZE'}
  ]
end
