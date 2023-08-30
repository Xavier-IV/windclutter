## Tailwind Buddy

Spam this buddy with your bulky TailwindCSS class, and sort it out later.

## Goal

Helping you stay focused and develop faster with your project.

## Concept

### 1 - Basic Cleanup
```bash
# standard button
$ tailwind_buddy -n border rounded-md px-4 py-2

# standard card
$ tailwind_buddy -n border rounded-md bg-white

$ tailwind_buddy --organize
[1/2] What do you want to do with this class?
'border rounded-md px-4 py-2'
name: .btn
Continue? [y/N]

[1/2] What do you want to do with this class?
'border rounded-md bg-white'
name: .card
Continue? [y/N]

Done!
Exported to compiled.css
```

Generated Output

```css
/* compiled.css */
.btn {
    @apply border rounded-md px-4 py-2;
}

.card {
    @apply border rounded-md bg-white;
}
```

### 2 - Guided cleanup

```bash
$ tailwind_buddy guided

[1/2] Cleanup progress
1. Global find this in your project:
class="border rounded-md px-4 py-2"

2. Replace with:
class="btn"

[2/2] Cleanup progress
1. Global find this in your project:
class="border rounded-md bg-white"

2. Replace with:
class="card"

Done!
```

## Contributing

Take a look into:
https://github.com/Xavier-IV/tail_draft/wiki/Developer