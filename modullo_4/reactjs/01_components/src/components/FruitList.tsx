// src/components/FruitList.tsx

interface Fruit {
  name: string
  emoji: string
  calories: number,
  peso: number
}

interface FruitListProps {
  fruits: Fruit[]
  title?: string
}

export default function FruitList({ fruits, title = 'Frutas' }: FruitListProps) {
  if (fruits.length === 0) {
    return <p style={{ color: '#999' }}>No hay frutas en la lista.</p>
  }

  return (
    <div>
      <h3 style={{ marginBottom: 8 }}>{title}</h3>
      <ul style={{ listStyle: 'none', padding: 0 }}>
        {fruits.map((fruit) => (
          <li
            key={fruit.name}
            style={{
              display: 'flex',
              justifyContent: 'space-between',
              padding: '8px 0',
              borderBottom: '1px solid #eee',
            }}
          >
            <span>{fruit.emoji} {fruit.name}</span>
            <span>Peso: {fruit.peso}</span>
            <span style={{ color: '#888', fontSize: 13 }}>{fruit.calories} kcal</span>
          </li>
        ))}
      </ul>
    </div>
  )
}