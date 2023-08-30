## Tailwind Buddy

Spam this buddy with your bulky TailwindCSS class, and sort it out later.

## Goal

Helping you stay focused and develop faster with your project.

## Concept

```bash
# standard button
$ tailwind_buddy border rounded-md px-4 py-2

# standard card
$ tailwind_buddy border rounded-md bg-white

$ tailwind_buddy organize
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