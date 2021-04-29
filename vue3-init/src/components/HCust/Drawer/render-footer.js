
export default {
    props: [
        // 数据来源
        'data',
    ],
    /* 这也可以  */
    setup(props) {
        return props.data
    },
}
