import fs from 'fs'

fs.appendFile('my-file.txt', 'Файл создан Node.js', (err) => {
    if(err) throw err
    console.log('Файл сохранен!')
})

// Время необходимое для проверки созданного файла my-file.txt
setTimeout(() => console.log('Конец'), 30000)