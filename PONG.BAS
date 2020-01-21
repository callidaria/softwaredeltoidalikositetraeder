SCREEN 7

p1 = 40: p2 = 150: bx = 150: by = 100: ba = -2.5: acc = 0: acc2 = 0
usu = 2: sf = 2

DO
        VIEW (0, 1)-(319, 198), 0, 15

        LINE (4, p1)-(4, p1 + 30), 14
        LINE (315, p2)-(315, p2 + 30), 14
        VIEW (bx, by)-(bx + 5, by + 5), 15, 15

        IF usu <= 0 THEN
                sf = sf + .5
                usu = sf
        END IF
        IF (p1 > 1 OR acc > 0) AND (p1 + 30 < 190 OR acc < 0) THEN
                p1 = p1 + acc: acc = 0
        END IF
        IF (p2 > 1 OR acc2 > 0) AND (p2 + 30 < 190 OR acc2 < 0) THEN
                p2 = p2 + acc2: acc2 = 0
        END IF

        IF by < 3 OR by > 190 THEN
                ba = ba * -1
        END IF
        IF bx < 3 OR bx > 310 THEN
                IF (by + 5 > p1 AND by < p1 + 30 AND bx < 3) OR (by + 5 > p2 AND by < p2 + 30 AND bx > 215) THEN
                        ba = (ba + 3.141) * -1
                        usu = usu - 1
                ELSE
                        bx = 150: by = 100: ba = -2.5
                END IF
        END IF
        bx = bx + COS(ba) * sf: by = by + SIN(ba) * sf

        SCREEN , , page%, 1 - page%: page% = 1 - page%
        WAIT &H3DA, &H8, &H8: WAIT &H3DA, &H8

        SELECT CASE INKEY$
                CASE CHR$(27): EXIT DO
                CASE "w", "W", CHR$(0) + "H": acc = -7
                CASE "s", "S", CHR$(0) + "P": acc = 7
                CASE "i", "I": acc2 = -7
                CASE "k", "K": acc2 = 7
        END SELECT
LOOP

SCREEN 0, 1, 0, 0: WIDTH 80, 25

