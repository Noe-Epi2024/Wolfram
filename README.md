
# 🌱 Wolfram Automaton

A terminal-based implementation of **Wolfram’s elementary cellular automaton** in Haskell.

---

## 📚 What is a Cellular Automaton?

A **cellular automaton** is a grid of cells that evolve through discrete steps based on a deterministic rule.  
Wolfram's elementary automata are **1D**, where each cell’s next state depends on the current state of its **left**, **center**, and **right** neighbors.

There are **256 possible rules** (from 0 to 255), such as rule **30**, **90**, or **110**.

---

## 🚀 Usage

```bash
cabal run wolfram -- [OPTIONS]
```

### ⚙️ Available Options

| Option        | Description                                                        |
|---------------|--------------------------------------------------------------------|
| `--rule N`    | Rule number to use (from 0 to 255)                                 |
| `--lines N`   | Number of generations (lines) to display                           |
| `--window N`  | Width of the display window (default: 80)                          |
| `--move N`    | Horizontal shift of the view (positive = right, negative = left)   |
| `--start N`   | Generation number to start rendering from                          |

### 🔍 Example

```bash
cabal run wolfram -- --rule 30 --lines 40 --window 120 --move 0
```

---

## 🛠 Installation & Build

Make sure you have [GHCup](https://www.haskell.org/ghcup/) installed.

### 1. Install dependencies

```bash
ghcup install cabal
cabal update
```

### 2. Build the project

```bash
cabal build
```

### 3. Run the app

```bash
cabal run wolfram -- --rule 110 --lines 30
```

---

## 🧱 Project Structure

```
wolfram/
├── app/
│   └── Main.hs          -- Entry point of the application
├── src/
│   ├── Automaton.hs     -- Automaton logic (rules, evolution)
│   └── Error.hs         -- Error handling and usage info
├── test/
│   └── Spec.hs          -- (Optional) Unit tests
├── wolfram.cabal        -- Cabal configuration file
└── README.md
```

---

## ✨ Visual Examples

### Rule 90

```
                         ■                         
                        ■ ■                        
                       ■   ■                       
                      ■ ■ ■ ■                      
                     ■       ■                     
                    ■ ■     ■ ■                    
                   ■   ■   ■   ■                   
```

### Rule 30

```
                         ■                         
                        ■■■                        
                       ■  ■                       
                      ■■■■■                      
                     ■    ■                     
                    ■■  ■■                    
                   ■  ■   ■                   
```

---

## 🧠 How It Works

1. A single `■` is placed in the center of the first line.
2. The rule (0–255) is converted to an 8-bit binary form.
3. Each generation is calculated by applying the rule to each triplet `(left, center, right)`.
4. The result is rendered in the terminal line by line.

---

## 📄 License

MIT © [Noé Jaïs](https://fr.linkedin.com/in/no%C3%A9jais)
