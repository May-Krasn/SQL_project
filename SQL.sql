-- 1. Znajdz wszystkich graczy, których postaci maja przedmiot o id 656

SELECT p.id, p.nazwa, po.gracz_email FROM przedmiot p
JOIN inwentarz_przedmiot ip ON p.Id = ip.Przedmiot_Id
JOIN inventory i ON i.id = ip.inventory_id
JOIN postac po ON po.inventory_id = i.id
WHERE p.id = 656;

-- 2. Oblicz ile razy przedmiot pojawia sie w inwentarzach graczy

SELECT COUNT(*), p.id, p.nazwa FROM przedmiot p
JOIN inwentarz_przedmiot ip ON p.Id = ip.Przedmiot_Id
JOIN inventory i ON i.id = ip.inventory_id
GROUP BY p.id, p.nazwa;

-- 3. Pokaz top graczy ranking ktorych jest powyzej 'Gold'

Select p.nickname, r.nazwa FROM postac p 
JOIN ranking r ON r.id = p.ranking_id
WHERE p.ranking_id > 4;

-- 4. Oblicz ile razy pojawia sie rzadkosc przedmiotow w bazie

SELECT rarity_id, COUNT(*) FROM przedmiot
GROUP BY rarity_id
HAVING COUNT(*) > 1;

-- 5. Wypisz ile graczy jest na kazdym z serwerow

Select s.id, s.nazwa, COUNT(*) From postac p
JOIN serwer s ON s.id = p.serwer_id
GROUP BY s.id, s.nazwa;

-- 6. Wybierz przedmioty, ktorych rzadkosc ocenia sie jako 'Unique'

SELECT p.nazwa, r.nazwa FROM przedmiot p
JOIN rarity r ON p.rarity_id = r.id
WHERE r.nazwa = (SELECT nazwa FROM rarity
                WHERE nazwa = 'Unique');

-- 7. Oblicz ile kazdy gracz ma postaci w tej grze

SELECT g.email, COUNT(*) AS liczba_postaci FROM gracz g
JOIN postac p ON g.email = p.gracz_email
GROUP BY g.email
ORDER BY COUNT(*);

-- 8. Wybierz graczy, ktorzy logowali sie w ostatnich dwoch miesiacach

SELECT email, ostatnie_logowanie FROM gracz
WHERE ostatnie_logowanie >= CURRENT_DATE - INTERVAL '2' MONTH;

-- 9. wypisz przedmioty, ktore pojawiaja sie w inwentarzach graczy najczesciej

SELECT p.nazwa, COUNT(*) AS ilosc FROM przedmiot p
JOIN inwentarz_przedmiot ip ON p.id = ip.przedmiot_id
GROUP BY p.nazwa 
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM przedmiot p
                JOIN inwentarz_przedmiot ip ON p.id = ip.Przedmiot_id
                GROUP BY p.nazwa);

-- 10. Podaj average ilosc miejsca w inwentarzach postaci kazdego gracza

SELECT g.email, AVG(i.ilosc_miejsca) FROM gracz g
JOIN Postac p ON p.gracz_email = g.email
JOIN inventory i ON p.inventory_id = i.id
GROUP BY g.email;

