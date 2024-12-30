
# Lexical Analyzer  

This project implements a lexical analyzer using **Lex**. It processes defined tokens to analyze a specific language, identifying keywords, operators, and important syntactic structures.

## Tokens Table  

Here are the tokens supported by the lexical analyzer, along with their models and attributes:  


| **Token**  | **Model**                      | **Attribute**          |
|------------|---------------------------------|------------------------|
| `FIN`      | `EOF` | `\0`                    | -                      |
| `PV`       | `;`                             | -                      |
| `IF`       | `if`                            | -                      |
| `THEN`     | `then`                          | -                      |
| `ELSE`     | `else`                          | -                      |
| `END`      | `end`                           | -                      |
| `REPEAT`   | `repeat`                        | -                      |
| `UNTIL`    | `until`                         | -                      |
| `ID`       | `L(_?\|(L\|C))*`                | `NOM`                  |
| `READ`     | `read`                          | -                      |
| `WRITE`    | `write`                         | -                      |
| `OPREL`    | `< \| =`                         | `COPREL ∈ {INF, EGAL}` |
| `OPADD`    | `+ \| -`                         | `COPADD ∈ {PLUS, MOINS}` |
| `OPMUL`    | `* \| /`                         | `COPMUL ∈ {PROD, DIV}` |
| `PARG`     | `(`                             | -                      |
| `PARD`     | `)`                             | -                      |
| `ENTIER`   | `C+`                      | `VAL`                  |
| `AFFECT`   | `:=`                            | -                      |

### Notes  
- The regular expressions `L` and `C` correspond to `[A-Za-z]` and `[0-9]`, respectively.  

## Features  
- **Lexical Analysis**: Identifies tokens in a textual input.  
- **Extended Support**: Handles operators, identifiers, and integers.  
- **Extensible**: Tokens can be modified or extended to fit other requirements.  

## Usage  

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/your_username/lexical-analyzer.git
   cd lexical-analyzer
   ```

2. **Compile the Lex File**  
   ```bash
   flex lexer.l
   gcc lex.yy.c -o lexical-analyzer -lfl
   ```

3. **Run the Lexical Analyzer**  
   ```bash
   ./lexical-analyzer < input.txt
   ```

## License  
This project is open-source and available under the [MIT License](LICENSE).  