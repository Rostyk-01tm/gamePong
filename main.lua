-- Стани гри
local gameState = "menu"

-- Розмір екрану
HEIGHT = 600
WIDTH = 800

-- Ракетки
local paddle1 = {x = 30, y = HEIGHT/2 - 40, width = WIDTH/80, height = HEIGHT/7.5, speed = 300}
local paddle2 = {x = WIDTH - 40, y = HEIGHT/2 - 40, width = WIDTH/80, height = HEIGHT/7.5, speed = 300}

-- М'яч
local ball = {x = WIDTH / 2, y = HEIGHT / 2, radius = WIDTH/100, speedX = 300, speedY = 300}


-- Рахунок
local score1 = 0
local score2 = 0
local maxScore = 11

function love.load()
    
    love.window.setTitle("Pong Classic")
    love.window.setMode(WIDTH, HEIGHT)
    -- font = love.graphics.newFont(24)
    font = love.graphics.newFont("Roboto-Regular.ttf", 20) -- Завантаження шрифту
    love.graphics.setFont(font)
end

function love.update(dt)
    if gameState == "play" then
        -- Рух ракеток
        if love.keyboard.isDown("w") then
            paddle1.y = paddle1.y - paddle1.speed * dt
        elseif love.keyboard.isDown("s") then
            paddle1.y = paddle1.y + paddle1.speed * dt
        end

        if love.keyboard.isDown("up") then
            paddle2.y = paddle2.y - paddle2.speed * dt
        elseif love.keyboard.isDown("down") then
            paddle2.y = paddle2.y + paddle2.speed * dt
        end

        -- 🔒 Обмеження руху в межах екрану (0..600 - paddle.height)
        paddle1.y = math.max(0, math.min(HEIGHT - paddle1.height, paddle1.y))
        paddle2.y = math.max(0, math.min(HEIGHT - paddle2.height, paddle2.y))

        -- Рух м'яча
        ball.x = ball.x + ball.speedX * dt
        ball.y = ball.y + ball.speedY * dt

        -- Відбивання від стін
        if ball.y <= 0 or ball.y >= 600 then
            ball.speedY = -ball.speedY
        end

        -- Відбивання від ракеток
        if checkCollision(ball, paddle1) then
            ball.speedX = math.abs(ball.speedX)
        elseif checkCollision(ball, paddle2) then
            ball.speedX = -math.abs(ball.speedX)
        end

        -- Вихід за межі
        if ball.x < 0 then
            score2 = score2 + 1
            resetBall()
        elseif ball.x > 800 then
            score1 = score1 + 1
            resetBall()
        end

        -- Перемога
        if score1 >= maxScore or score2 >= maxScore then
            gameState = "menu"
        end
    end
end

function love.draw()
    love.graphics.setFont(font)

    if gameState == "menu" then
        love.graphics.printf("PONG", 0, HEIGHT / 6, WIDTH, "center")
        
        -- START
        love.graphics.rectangle("line", WIDTH / 2 - 100, HEIGHT / 2 - 50, 200, 50)
        love.graphics.printf("START", 0, HEIGHT / 2 - 35, WIDTH, "center")

        -- EXIT
        love.graphics.rectangle("line", WIDTH / 2 - 100, HEIGHT / 2 + 20, 200, 50)
        love.graphics.printf("EXIT", 0, HEIGHT / 2 + 35, WIDTH, "center")

        
        if score1 >= maxScore then
            love.graphics.printf("Гравець 1 переміг!", 0, 400, 800, "center")
        elseif score2 >= maxScore then
            love.graphics.printf("Гравець 2 переміг!", 0, 400, 800, "center")
        end
    elseif gameState == "play" then
        -- Ракетки
        love.graphics.rectangle("fill", paddle1.x, paddle1.y, paddle1.width, paddle1.height)
        love.graphics.rectangle("fill", paddle2.x, paddle2.y, paddle2.width, paddle2.height)

        -- М'яч
        love.graphics.circle("fill", ball.x, ball.y, ball.radius)

        -- Рахунок
        love.graphics.print(score1, 300, 20)
        love.graphics.print(score2, 470, 20)
    end
end

function love.mousepressed(x, y, button)
    if gameState == "menu" and button == 1 then
        -- START
        if x > 300 and x < 500 and y > 250 and y < 300 then
            score1 = 0
            score2 = 0
            resetBall()
            gameState = "play"
        end

        -- EXIT
        if x > 300 and x < 500 and y > 320 and y < 370 then
            love.event.quit()
        end
    end
end
   

function love.keypressed(key)
    if gameState == "menu" then
        if key == "return" then
            score1 = 0
            score2 = 0
            resetBall()
            gameState = "play"
        elseif key == "escape" then
            love.event.quit()
        end
    end
end

-- Перевірка зіткнення м’яча з ракеткою
function checkCollision(ball, paddle)
    return ball.x - ball.radius < paddle.x + paddle.width and
           ball.x + ball.radius > paddle.x and
           ball.y - ball.radius < paddle.y + paddle.height and
           ball.y + ball.radius > paddle.y
end

-- Перезапуск м’яча
function resetBall()
    ball.x = WIDTH / 2
    ball.y = HEIGHT / 2
    ball.speedX = ball.speedX * -1
    ball.speedY = (math.random() - 0.5) * 600
end


--[[
function menu()
  
  
  
  
  
end

функція МЕНЮ() {
    показати кнопку [START]
    показати кнопку [EXIT]

    якщо (натиснуто кнопку [START]) {
        викликати функцію ГРА()
    }
    інакше якщо (натиснуто кнопку [EXIT]) {
        завершити програму
    }
}

змінна балиГравця1 = 0
змінна балиГравця2 = 0

Player1_Points = 0
Player2_Points = 0

function game()
    ball = {x = 0, y = 0, speed = 1}
    tenisRacket1 = {x = 20, y = 50, racketSpeed = 0.8}
    tenisRacket2 = {x = 280, y = 50, racketSpeed = 0.8}
    
    repeat
      
      
      
    until Player1_Points == 11 or Player2_Points == 11
    
end


функція ГРА() {
    ініціалізувати позицію м'яча (центр)
    ініціалізувати швидкість м'яча (випадковий напрямок)
    встановити позиції ракеток

    

    ПОКИ (гра не завершена) {
        обробити керування гравців (W/S, ↑/↓)
        перемістити м'яч за напрямком

        якщо (м'яч стикається з верхньою або нижньою стіною) {
            змінити вертикальний напрямок м'яча
        }

        якщо (м'яч стикається з ракеткою гравця 1 або 2) {
            змінити горизонтальний напрямок м'яча
        }

        якщо (м'яч вийшов за ліву межу) {
            балиГравця2++
            перезапустити м'яч із центру
        }

        якщо (м'яч вийшов за праву межу) {
            балиГравця1++
            перезапустити м'яч із центру
        }

        якщо (балиГравця1 >= 10 або балиГравця2 >= 10) {
            гра завершена
            показати екран "Гравець 1/2 переміг"
            запропонувати повернення в меню
        }

        оновити екран (м'яч, ракетки, рахунок)
    }
}


]]