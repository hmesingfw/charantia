<template>
    <div>
        <div id="wrapper">
            <div id="content">
                <img id="test-picture" class="picture" width="1280" />
                <canvas id="canvas" class="canvas" @mouseup="onMouseUp" @mousedown="onMouseDown" @mousemove="onMouseMove" />
            </div>
        </div>
        <div id="uImgWrapper">
            <div id="uImgContainer">
                <div id="uImgInner">
                    <div id="dndArea">
                        <div id="filePicker">
                            <div id="uploader-pick">点击选择图片</div>
                        </div>
                        <input id="file-upload" ref="imageRef" type="file" accept="image/*" @change="imgChange(this)" />
                        <p>请将要抠的图片拖到这里~</p>
                    </div>
                </div>
            </div>
        </div>
        <div id="panel" style="position: fixed;    left: 0;">
            <div class="panelBtn" @click="reloadImg">加载新图片</div>
            <div class="panelBtn" @click="downloadImg">下载图片</div>
            <div class="panelBtn" @click="clearSelected">重置勾选</div>
            <div class="panelBtn" @click="clearSelectedImage">清除图像</div>
            <label id="thresholdLable">容差：</label>
            <input id="colorThreshold" type="number" min="0" max="442" value="15" />
        </div>
    </div>
</template>

<script>
import MagicWand from './MagicWand'
export default {
    data() {
        return {
            colorThreshold: 15,
            imageInfo: null,
            tempCanvas: null,
            cacheInd: null,
            delResData: null,
            predelResData: null,
            mask: null,
            downPoint: null,
            allowDraw: false,
            currentThreshold: 15,
            scaleStep: 0.1,
            newScale: 1,
            minScale: 0.5,
            maxScale: 3,
            hatchLength: 4,
            hatchOffset: 0,
        }
    },
    mounted() {
        const imgConetent = document.getElementById('content');
        imgConetent.style.maxWidth = window.innerWidth + 'px';
        imgConetent.style.maxHeight = window.innerHeight + 'px';

        this.EventInit();
        setInterval(() => { this.hatchTick(); }, 300);
    },
    methods: {
        EventInit() {
            const _this = this;
            // Init MouseWheel Event
            var content = document.getElementById('content');
            content.addEventListener('mousewheel', this.handleMouseWheel);

            document.getElementById('filePicker').addEventListener('click', function () {
                document.getElementById('file-upload').click();
            });

            // Drag Add Image
            var dropContainer = document.querySelector('#dndArea');

            dropContainer.addEventListener('dragover', function (e) {
                e.stopPropagation();
                e.preventDefault();
                e.dataTransfer.dropEffect = 'link';
                if (!dropContainer.classList.contains('uploaderOver')) dropContainer.classList.add('uploaderOver');
            }, false);

            dropContainer.addEventListener('dragleave', function () {
                dropContainer.classList.remove('uploaderOver');
            }, false);

            dropContainer.addEventListener('drop', function (e) {
                e.stopPropagation();
                e.preventDefault();
                var reader = new FileReader();
                // validate
                var ext = e.dataTransfer.files[0].name.substring(e.dataTransfer.files[0].name.lastIndexOf('.') + 1).toLowerCase();
                if (ext != 'png' && ext != 'jpg' && ext != 'jpeg') {
                    alert('图片的格式必须为png或者jpg或者jpeg格式！');
                    return;
                }
                reader.onload = function (e) {
                    var src = e.target.result;
                    var img = document.getElementById('test-picture');
                    img.setAttribute('src', src);
                    img.onload = function () {
                        _this.initCanvas(img);

                        //  不使用jquery , 不带过渡动画
                        document.getElementById('uImgWrapper').style.display = 'none'

                        document.getElementById('wrapper').style.display = 'block'
                        document.getElementById('panel').style.display = 'block'
                    };
                    dropContainer.classList.remove('uploaderOver');
                };
                reader.readAsDataURL(e.dataTransfer.files[0]);
            }, false);

            document.onkeydown = function (e) {
                // Revoke (command+Z or ctrl+Z)
                if (e.metaKey && e.keyCode === 90 || e.ctrlKey && e.keyCode === 90) {
                    e.preventDefault();
                    if (this.mask && this.mask.data.length && this.mask.predata.length) {
                        if (!this.predelResData) {
                            var _ref = [this.mask.predata, this.mask.data];
                            this.mask.data = _ref[0];
                            this.mask.predata = _ref[1];
                        } else if (this.predelResData) {
                            this.delResData = this.predelResData;
                            this.predelResData = null;
                        }
                        this.drawBorder();
                    }
                }
                // Reset
                if (e.metaKey && e.keyCode === 68 || e.ctrlKey && e.keyCode === 68) {
                    e.preventDefault();
                    if (this.mask) {
                        var _ref2 = [[], this.mask.data];
                        this.mask.data = _ref2[0];
                        this.mask.predata = _ref2[1];

                        this.delResData = null;
                        this.predelResData = null;
                        MagicWand.clearPreData();
                        this.drawBorder();
                    }
                }

                // Delete
                if (e.metaKey && e.keyCode === 46 || e.metaKey && e.keyCode === 8 || e.ctrlKey && e.keyCode === 46 || e.ctrlKey && e.keyCode === 8) {
                    e.preventDefault();
                    if (this.mask) {
                        this.drawBorder(null, true);
                    }
                }
                // Add colorThreshold
                if (e.keyCode === 87) {
                    // W
                    e.preventDefault();
                    var _colorThreshold = document.getElementById('colorThreshold').value;
                    if (parseInt(_colorThreshold, 10) < 442) _colorThreshold = parseInt(_colorThreshold, 10) + 1;
                }
                // reduce colorThreshold
                if (e.keyCode == 83) {
                    // S
                    e.preventDefault();
                    var _colorThreshold2 = document.getElementById('colorThreshold').value;
                    if (parseInt(_colorThreshold2, 10) > 0) _colorThreshold2 = parseInt(_colorThreshold2, 10) - 1;
                }
            };
        },

        initCanvas(img) {
            this.maxScale = window.innerWidth / document.getElementById('test-picture').width + 2;
            var imgTemp = new Image();
            imgTemp.src = img.src;
            const cvs = document.getElementById('canvas');
            const imgContain = document.getElementById('test-picture');
            const sh = imgTemp.height / (imgTemp.width / imgContain.width);
            cvs.width = imgContain.width;
            cvs.height = sh;
            // getImageData pass to Magicwands
            this.imageInfo = {
                width: imgContain.width,
                height: sh,
                context: cvs.getContext('2d')
            };
            this.mask = null;
            // this canvas use for save source image data and export
            this.tempCanvas = document.createElement('canvas');
            var tempCtx = this.tempCanvas.getContext('2d');
            tempCtx.canvas.width = this.imageInfo.width;
            tempCtx.canvas.height = this.imageInfo.height;
            tempCtx.drawImage(img, 0, 0, this.imageInfo.width, this.imageInfo.height);
            this.imageInfo.data = tempCtx.getImageData(0, 0, this.imageInfo.width, this.imageInfo.height);
        },

        imgChange() {
            const _this = this;
            const inp = this.$refs.imageRef
            if (inp.files && inp.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var src = e.target.result;
                    var img = document.getElementById('test-picture');
                    img.setAttribute('src', src);
                    img.onload = function () {
                        _this.initCanvas(img);

                        //  不使用jquery , 不带过渡动画
                        document.getElementById('uImgWrapper').style.display = 'none'

                        document.getElementById('wrapper').style.display = 'block'
                        document.getElementById('panel').style.display = 'block'
                    };
                };
                reader.readAsDataURL(inp.files[0]);
            }
        },

        getMousePosition(e) {
            var left = e.target.offsetLeft;
            var top = e.target.offsetTop;
            var x = Math.round((e.clientX || e.pageX) - left);
            // relative canvas
            var y = Math.round((e.clientY || e.pageY) - top);

            return { x: x, y: y };
        },

        onMouseDown(e) {
            if (e.button == 0) {
                // union
                this.allowDraw = true;
                this.downPoint = this.getMousePosition(e);
                this.colorThreshold = parseInt(document.getElementById('colorThreshold').value, 10) || 15;
                this.currentThreshold = this.colorThreshold;
                // reduction
                this.drawMask(parseInt(this.downPoint.x / this.newScale, 10), parseInt(this.downPoint.y / this.newScale), 10);
            } else {
                this.allowDraw = false;
            }
        },

        onMouseMove(e) {
            if (this.allowDraw) {
                var p = this.getMousePosition(e);
                if (p.x != this.downPoint.x || p.y != this.downPoint.y) {
                    var dx = p.x - this.downPoint.x;
                    var dy = p.y - this.downPoint.y;
                    var len = Math.sqrt(dx * dx + dy * dy);
                    var sign = dy < 0 ? 1 / 10 : 1 / 2; // mouse move direction depend colorThreshold increase slow or quick(//TODO	subtract)
                    var thres = Math.min(Math.max(this.colorThreshold + Math.floor(sign * len), 1), 255);
                    if (thres != this.currentThreshold) {
                        this.currentThreshold = thres;
                        this.drawMask(parseInt(this.downPoint.x / this.newScale, 10), parseInt(this.downPoint.y / this.newScale), 10);
                    }
                }
            }
        },

        onMouseUp() {
            this.allowDraw = false;
            this.currentThreshold = this.colorThreshold;
        },

        drawMask(x, y) {
            if (!this.imageInfo) return;
            var image = {
                data: this.imageInfo.data.data,
                width: this.imageInfo.width,
                height: this.imageInfo.height,
                bytes: 4
            };

            this.mask = MagicWand.floodFill(image, x, y, this.currentThreshold);
            this.drawBorder();
        },

        hatchTick() {
            this.hatchOffset = (this.hatchOffset + 1) % (this.hatchLength * 2);
            this.drawBorder(true);
        },

        drawBorder(noBorder, noFill) {
            if (!this.mask) return;
            var x = void 0;
            var y = void 0;
            var i = void 0;
            var j = void 0;
            var k = void 0;
            var w = this.imageInfo.width;
            var h = this.imageInfo.height;
            var ctx = this.imageInfo.context;
            var imgData = ctx.createImageData(w, h);
            var res = imgData.data;

            if (!noBorder) {
                this.cacheInd = MagicWand.getBorderIndices(this.mask); // cache
                this.predelResData = null;
            }

            ctx.clearRect(0, 0, w, h);

            var len = this.cacheInd.length;
            for (j = 0; j < len; j++) {
                i = this.cacheInd[j];
                x = i % w; // calc x by index
                y = (i - x) / w; // calc y by index
                k = (y * w + x) * 4;
                if ((x + y + this.hatchOffset) % (this.hatchLength * 2) < this.hatchLength) {
                    // detect hatch color
                    res[k + 3] = 255; // black, change only alpha
                } else {
                    res[k] = 255; // white
                    res[k + 1] = 255;
                    res[k + 2] = 255;
                    res[k + 3] = 255;
                }
            }

            if (noFill) this.delResData = MagicWand.getCurrentResult(this.mask);
            if (this.delResData) {
                this.predelResData = null;
                for (j = 0; j < this.delResData.length; j++) {
                    i = this.delResData[j];
                    x = i % w; // calc x by index
                    y = (i - x) / w; // calc y by index
                    k = (y * w + x) * 4;
                    res[k] = 255; // white
                    res[k + 1] = 255;
                    res[k + 2] = 255;
                    res[k + 3] = 255;
                }
            }
            ctx.putImageData(imgData, 0, 0);
        },

        imgToCanvas() {
            var x = void 0;
            var y = void 0;
            var i = void 0;
            var j = void 0;
            var k = void 0;
            var w = this.imageInfo.width;
            var h = this.imageInfo.height;
            var ctx = this.tempCanvas.getContext('2d');
            var imageData = ctx.getImageData(0, 0, w, h);
            var res = imageData.data;
            this.delResData = MagicWand.getCurrentResult(this.mask);
            if (this.delResData) {
                for (j = 0; j < this.delResData.length; j++) {
                    i = this.delResData[j];
                    x = i % w; // calc x by index
                    y = (i - x) / w; // calc y by index
                    k = (y * w + x) * 4;
                    res[k] = 0; // white
                    res[k + 1] = 0;
                    res[k + 2] = 0;
                    res[k + 3] = 0;
                }
            }
            ctx.putImageData(imageData, 0, 0);
        },

        downloadImg(e) {
            // First try a.download, then web filesystem, then object URLs
            // just use a.download
            e.stopPropagation();
            this.imgToCanvas();
            this.tempCanvas.toBlob(function (blob) {
                var aTemp = document.createElement('a');
                aTemp.setAttribute('href', URL.createObjectURL(blob));
                aTemp.setAttribute('download', 'Magic.png');

                var evObj = document.createEvent('MouseEvents');
                evObj.initMouseEvent('click', true, true, window, 0, 0, 0, 0, 0, false, false, true, false, 0, null);
                aTemp.dispatchEvent(evObj);
            });
        },

        reloadImg() {
            if (this.mask && this.mask.data) {
                var _ref3 = [[], this.mask.data];
                this.mask.data = _ref3[0];
                this.mask.predata = _ref3[1];
            }
            this.delResData = null;
            this.predelResData = null;
            MagicWand.clearPreData();

            document.getElementById('uImgWrapper').style.display = 'block'

            document.getElementById('wrapper').style.display = 'none'
            document.getElementById('panel').style.display = 'none'
        },

        // TODO：完善 滚轮放大、空格拖拽（实现PS中的效果）
        // 滚轮放大：在scale小于1的情况下滚轮放大以中心为焦点进行放大，大于1后跟随鼠标位置进行放大
        // 空格拖拽：在放大的情况下，按住空格后对img、canvas的位置控制
        handleMouseWheel(e) {
            var wd = e.wheelDelta;
            this.newScale += wd > 0 ? this.scaleStep : -this.scaleStep;
            this.newScale = this.newScale < this.minScale ? this.minScale : this.newScale;
            this.newScale = this.newScale > this.maxScale ? this.maxScale : this.newScale;
            // img、canvas change need synchronization
            var imgContain = document.getElementById('test-picture');
            var canvas = document.getElementById('canvas');
            var content = document.getElementById('content');

            if (parseInt(canvas.width * this.newScale, 10) > window.innerWidth || parseInt(canvas.width * this.newScale, 10) > window.innerWidth) {
                imgContain.style.transformOrigin = 'left top';
                canvas.style.transformOrigin = 'left top';
                this.tempCanvas.style.transformOrigin = 'left top';
            } else {
                imgContain.style.transformOrigin = 'center center';
                canvas.style.transformOrigin = 'center center';
                this.tempCanvas.style.transformOrigin = 'center center';
            }
            imgContain.style.transform = 'scale(' + this.newScale + ')';
            canvas.style.transform = 'scale(' + this.newScale + ')';
            this.tempCanvas.style.transform = 'scale(' + this.newScale + ')';

            if (parseInt(canvas.width * this.newScale, 10) > window.innerWidth) {
                content.style.overflowX = 'scroll';
            } else if (parseInt(canvas.height * this.newScale, 10) > window.innerHeight) {
                content.style.overflowY = 'scroll';
            } else {
                content.style.overflow = 'hidden';
            }
        },

        /* 清除选中 */
        clearSelected() {
            if (this.mask) {
                var _ref2 = [[], this.mask.data];
                this.mask.data = _ref2[0];
                this.mask.predata = _ref2[1];

                this.delResData = null;
                this.predelResData = null;
                MagicWand.clearPreData();
                this.drawBorder();
            }
        },
        clearSelectedImage() {
            if (this.mask) {
                this.drawBorder(null, true);
            }
        },
    },
}
</script>
<style scoped>
@import "./style.css";
</style>
