<template>
    <div class="h-i">
       
        <div class="item">
            <div class="matters-need">
                <div>注意事项</div>
                <div class="matters-need-border"></div>
            </div>

            <div class="item-main">
                <div class="item-content">
                    <div>注意事项</div>
                    <div class="item-main-option"></div>
                </div>
                <div class="item-content">
                    <div>注意事项</div>
                    <div class="item-main-option"></div>
                </div>
                <div class="item-content">
                    <div>注意事项</div>
                    <div class="item-main-option"></div>
                </div>
                <div class="item-content">
                    <div>注意事项</div>
                    <div class="item-main-option"></div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {

}
</script>
<style lang="scss">
.h-i {
    .item {
        display: flex;
        align-items: center;
        .matters-need {
            width: 20%;
            padding-left: 5.5em;
            .matters-need-border {
                border: 1px solid blue;
                height: 10em;
            }
        }

        .item-main {
            width: 80%;
            padding-left: 1.5em;
            padding-right: 5.5em;

            display: flex;
            flex-wrap: nowrap;
            .item-content {
                width: 20%;
                margin-left: 1.5em;
                .item-main-option {
                    width: 100%;
                    height: 10em;
                    border: 1px solid blue;
                }
            }
        }
    }
}
</style>