SCREEN 7

px = 25
sx = 0: sy = 0: sr = 0
DIM ssx(60) AS INTEGER: DIM ssy(60) AS INTEGER: DIM ssr(60) AS INTEGER
DIM esr(12) AS INTEGER: DIM esx(12) AS INTEGER: DIM esy(12) AS INTEGER
um = 100

FOR j = 0 TO 4
        FOR i = 0 TO 11
                ssx(j * 12 + i) = i * 25 + 10: ssy(j * 12 + i) = j * 15 + 10
        NEXT i
NEXT j

DO
        VIEW (0, 0)-(319, 199), 0, 15 'refresh viewport

        IF px < 5 THEN 'player movement bounds
                px = 5
        ELSEIF px > 309 THEN
                px = 309
        END IF
        LINE (px, 195)-(px + 5, 189), 15, BF 'rendering player

        IF sy > 0 THEN 'process shooting
                IF sr = 1 THEN
                        sy = sy - 5
                        LINE (sx, sy)-(sx, sy - 3), 15
                END IF
        ELSE
                sr = 0: sx = 0: sy = 0
        END IF

        FOR j = 0 TO 4 'process alien spaceships
                FOR i = 0 TO 11
                        pt = j * 12 + i
                        IF ssr(pt) < 1 THEN
                                tx = ssx(pt): ty = ssy(pt)
                                IF sx <= tx + 10 AND sx >= tx AND sy >= ty AND sy <= ty + 10 THEN
                                        ssr(pt) = 1
                                        sr = 0
                                ELSE
                                        IF um = 0 THEN 'check enemy movement
                                                ssy(pt) = ssy(pt) + 5
                                        END IF
                                        LINE (tx, ty)-(tx + 10, ty + 10), 15, B
                                END IF
                        END IF
                NEXT i
        NEXT j
        IF um > 0 THEN 'enemy movement reset d
                um = um - 1
        ELSE
                um = 100
        END IF

        SCREEN , , page%, 1 - page%: page% = 1 - page%
        WAIT &H3DA, &H8, &H8: WAIT &H3DA, &H8

        SELECT CASE INKEY$ 'input processing
                CASE CHR$(27): EXIT DO
                CASE CHR$(0) + CHR$(75): px = px - 5 'player movement
                CASE CHR$(0) + CHR$(77): px = px + 5
                CASE "s", "S":
                        IF sr < 1 THEN 'setting shot
                                sx = px + 3
                                sy = 189
                                sr = 1
                        END IF
        END SELECT
LOOP

SCREEN 0, 1, 0, 0: WIDTH 80, 25

