const path = require('path');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

module.exports = {
  // 其他配置...
  plugins: [
    new MiniCssExtractPlugin({
      filename: "[name].css",
      chunkFilename: "[id].css",
    }),
  ],
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
            options: {},
          },
          'css-loader',
        ],
      },
    ],
  },
};
module.exports = {
  entry: './index.js',
  output: {
    filename: 'dist.js',
    path: path.join(__dirname, 'dist'),
  },
  module: {
    rules: [{
      test: /\.css$/,
      use: [{
          loader: MiniCssExtractPlugin.loader,
        },
        'css-loader',
      ],
      exclude: /node_modules/,
    }, {
      test: /\.(png|jpg|gif)$/,
      use: 'file-loader',
    }],
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: "[name].css",
      chunkFilename: "[id].css",
    }),
  ],
  mode: 'development',
  devServer: {
    port: 8080, // 端口号
    open: true, // 是否自动打开浏览器
    host: '0.0.0.0', // 允许外部访问
    hot: true, // 启用热重载
    static: './dist', // 静态文件目录（替代contentBase）
    // 如果需要代理，可以这样配置
    // proxy: {
    //   '/api': {
    //     target: 'http://localhost:5000', // 目标API地址
    //     changeOrigin: true, // 是否跨域
    //     pathRewrite: { '^/api': '' } // 路径重写
    //   }
    // }
  }
}