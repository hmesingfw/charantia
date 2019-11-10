<template>
    <div class="panel-title">
        <img class="image" src="~@/assets/title.png" alt />
        <span class="color-890">{{ year }}年{{month}}月{{date}}日 {{day}} {{hours}}:{{minutes}}</span>
    </div>
</template>

<script>
export default {
    data() {
        return {
            year: '',
            month: '',
            date: '',
            day: '',
            hours: '',
            minutes: ''
        }
    },
    created() {
        this.init();
        this.setInt();
    },
    methods: {
        setInt() {
            setInterval(() => {
                this.init();
            }, 60000);
        },
        init() {
            var d = new Date();
            this.year = d.getFullYear();
            this.month = d.getMonth() + 1;
            this.date = d.getDate();

            switch (new Date().getDay()) {
                case 0:
                    this.day = "星期天";
                    break;
                case 1:
                    this.day = "星期一";
                    break;
                case 2:
                    this.day = "星期二";
                    break;
                case 3:
                    this.day = "星期三";
                    break;
                case 4:
                    this.day = "星期四";
                    break;
                case 5:
                    this.day = "星期五";
                    break;
                case 6:
                    this.day = "星期六";
            }
            this.hours = d.getHours();
            this.minutes = d.getMinutes() + 1;


        }
    }
}
</script>
<style lang="scss" >
.panel-title {
    display: flex;
    justify-content: center;

    .color-890 {
        color: #109b9d;
        font-size: 20px;
        line-height: 120px;
    }
}
</style>