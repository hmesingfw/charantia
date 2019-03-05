<template>
    <div class="hamburger">
        <img
            class="image"
            src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAYAAACtWK6eAAAHQ0lEQVR4nO3d0XGjShCF4ROCQ5gQHAIhbAiE4BDIwCEQwoZACBsCISgE3QdZtV5fy4yG7mZm+L8qap+2dAbpSIhGRgIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA9GKQ9C7pj6T149/fkiZJ6ahQwNEG3cpw3djmg/IBh3jR7RNiqxiftz8f/w/o3rueK8d9WyW9HpAXCPOmsnJ8LgnQpVftK8d9G4NzAyFm2RSETxF0aZVNQa6SfgVnB1xZHV7dt7fY+ICvUbYFmUPTA872nr2iIOia1Rf0+/YeGx+9elEd1zM9Oznf2kbjfLXsJwQYdHvHvujfF9VFt3fedEAmyzNYVmexBt32x9f9dP+EYmrfmRc9fsK/blNwNuuC7HnxPrOfOJTrxKvyroz9vEVdAJiezJWzpR1ZSvZT6eOhAq/Kezf8bluC8lmW47Ijy7LjMTnkatCecty30TnjuDPfd+/oJfaeaqYkjbEox/2JT445rWcgvwsyJNntK0rSAKty3DfPSzdmw5xXlX1xngwfn5JUzrocpe/KuWqYgSzGGShJpTzKcX/CvazGWUtmINYZKEmFvMpxle9vLKyzpgoyUJLKeJbjqvIzQ1uSQ9ZUkMPjE4SSVMK7HFf5fQexnoGshTkW4xyUpBIR5bjKbxYyGucs/aSzzkFJKhBVjov8LjmpYQYi3dbnvR8pSaCoclzV/wzkzrqslOQgkeWYnddSwwzks8U4DyUJFl0O76t5V+PMFr8DoSSN6q0ccsidjHJRksb0WI7kkD0Z5qMkjeixHNLtJ62W2VeHjJSkcr2WQ6pnBrKFklSq53JIbf0tLEpSmd7LIdU1A8lBSSpxhnJI9c1AclCSg52lHFKdM5AclOQgZyqHZL+mFJidkgQ7WzmS2i6IREnCnK0cUhszkByUxNkZyyG1MwPJQUmcnLUcUlszkByUxNiZyyG1NwPJQUmMnL0cUpszkByUZCfKcbPKdq013dWWkhSiHH9ZrzeFpt9GSZ5EOf5K6r8gEiXJRjn+Nch2zWto+udQkg2U4/9G2a77yBlIDkryAOX4Xm8zkByU5AvK8dgs2/XXMAPJQUk+UI6f9ToDyXH6klCObats90NNM5AckSWp6vXxoudvIXy2ckj2+yKFprcRVZIlakE5JlGOLUkU5C6qJJ5/WzlbUsyhVcvlkM41A8kRVZIUtJ6HRlGOHKNs90ntM5AcESU5/FPkXZQjxxlnIDm8S+J5l+Is1qcueyyHdN4ZSA7PkiyB6/iW59mrwz8eDZ15BrLF8wY+hxfEs/09vRBW2e6X1mYgj3jf3erwT1rv7yC9lMR6n6TQ9D4ibv02Ri3mEevbGVe70B2S7PdH66LuizgEredHiyjJTwbZ7oc1NL29qHIcfnh19yL7Y+yeSjLKdh+0PAOJvKNuVWdAB8UsvMWSMAO5iSrHVZWeAY3cAWPMkkzMsl17NYcOT4h8bUwxSypDSf7v7DMQyvEFJfnXKts1tzQDoRwPUJK/rNebQtOXoxwbKInPnKgFlCPT2UsyyHaNa2j6MpTjSWcuySjb9S2h6Z9HOQqdtSRnmoFQjp3OWJJZtuuqdQZCOYycrSRnmIFQDmNnKskq2/XUNgOhHE7OUhLrtaTQ9D+jHM56L0nPMxDKEaTnkgwGmT9va2j6xyhHsF5LMhpnXwKzP0I5DtJjSXqbgVCOg/VWEutTvEfOQChHJXoqydJY3kcoR2V6KclqnPWIGQjlqFQPJbHOmZxyPkI5KtdySVqfgVCORrRaksE422qYbQvlaEyLJbHOvBjlis5NOYK0VpLJONNskGkL5WhcSyVpbQZCOToR+UTuud/2Ypxl3JFly2CclXIcLKok646Mq3EWrxlI5C28J6c14BtRJSl9YVrnSIU5tvxyyEo5KhFRkrkgV0szEM97TFKOCniXpORWA4NxhrUgQ67VOCvlqJBnSS4V5FkKMuTyLMjkmBtP8ipJybv3ZJxhLsiQ62KclXJUzKMkJYdYLc1APM5gTY55sZN1SUpenItxhrEgQy7ruxRPjllhxLIkQ8Hjr4aPf5Xv70AGw5yTY04YsyhJ6aGNZTmu8v8diMUh4eScEQ72lGRV2V1SW5qB3O29S/EUkBFORj3/hF9UflgzFDzeVlEjlOS+qNK7yeI5r8o/W7No3yFNSzOQr57ZT3+072JOVGjW9rvh3pvPTz88Rsk278xT4k2P5yMX3da4dz+hYr90O/R6+/j3VXZPeEszkC2e+wkntci2IGNoesCZdUFqux8IsIt1QVJoesCZ5aUbJdeBAVVLsivI79joQAyrM1lDcG4gRNL+cszRoYFIs/Z992DegO5NohzAj0blFeOi23eXdERI4EhJt0Ou765vuheDC/8A3coyfGxc2wQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHfoP2WvQ5OnwK18AAAAASUVORK5CYII="
            @click="toggleClick"
        >
    </div>
</template>

<script>
// @click="toggleClick"
export default {
    name: 'Hamburger',
    props: {
        isActive: {
            type: [Boolean, String],
            default: false
        },
        toggleClick: {
            type: Function,
            default: null
        }
    },
}
</script>

<style lang="less" scoped>
.hamburger {
    display: inline-block;
    cursor: pointer;
    width: 30px;
    height: 30px;
    
    .image {
        width: 100%;
        height: 100%;
    }
}

</style>
